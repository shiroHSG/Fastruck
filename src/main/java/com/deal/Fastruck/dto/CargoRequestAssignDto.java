package com.deal.Fastruck.dto;
import com.deal.Fastruck.entity.enums.CargoRequestStatus;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CargoRequestAssignDto {
    private Long carrierId; // 배정할 운송기사 Member의 id
}
